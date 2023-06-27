float4 SoftPt_Rate;
float4 ambient_rate;
float4 finalcolor_enhance;
float3 fog;
float4 g_CameraParam;
float4 g_TargetUvParam;
sampler g_Z_sampler;
sampler nkiMask_sampler;
float4 nkiTile;
float4 prefogcolor_enhance;

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = 1 / i.texcoord8.w;
	r0.xy = r0.xx * i.texcoord8.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(g_Z_sampler, r0);
	r0.x = r0.x * g_CameraParam.y + g_CameraParam.x;
	r0.x = r0.x + -i.texcoord8.w;
	r0.y = abs(SoftPt_Rate.x);
	r0.y = 1 / r0.y;
	r0.x = r0.y * r0.x;
	r0.y = -r0.x + 1;
	r0.zw = float2(0.5, -0.5);
	r1.x = (SoftPt_Rate.x >= 0) ? r0.w : r0.z;
	r1.y = (-SoftPt_Rate.x >= 0) ? -r0.w : -r0.z;
	r1.x = r1.y + r1.x;
	r1.x = (r1.x >= 0) ? -r1.x : -0;
	r0.x = (r1.x >= 0) ? r0.x : r0.y;
	r1.xy = i.texcoord.zw * nkiTile.xy + nkiTile.zw;
	r1 = tex2D(nkiMask_sampler, r1);
	r2 = float4(-0, -0, -0, -1) + i.color;
	r2 = SoftPt_Rate.y * r2 + r0.wwwz;
	r0.y = r1.w * r2.w;
	r1.xyz = r2.xyz * ambient_rate.xyz;
	r2.xyz = fog.xyz;
	r1.xyz = r1.xyz * prefogcolor_enhance.xyz + -r2.xyz;
	r1.xyz = i.texcoord1.www * r1.xyz + fog.xyz;
	r0.y = r0.y * ambient_rate.w;
	r2 = r0.y * r0.x + -0.01;
	r0.x = r0.x * r0.y;
	r1.w = r0.x * prefogcolor_enhance.w;
	o = r1 * finalcolor_enhance;
	clip(r2);

	return o;
}
