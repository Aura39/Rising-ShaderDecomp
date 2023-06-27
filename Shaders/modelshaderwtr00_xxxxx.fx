float4 SoftPt_Rate;
float4 ambient_rate;
float4 finalcolor_enhance;
float3 fog;
float4 g_CameraParam;
float4 g_TargetUvParam;
float4 g_WtrFogColor;
float4 g_WtrFogParam;
sampler g_Z_sampler;
float4 prefogcolor_enhance;

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0.xyz = finalcolor_enhance.xyz;
	r0.w = -1 + i.color.w;
	r1.zw = float2(0.5, -0.5);
	r0 = SoftPt_Rate.y * r0 + -r1.wwwz;
	r0.w = r0.w * ambient_rate.w;
	r0 = r0 + -g_WtrFogColor;
	r1.xy = i.texcoord8.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(g_Z_sampler, r1);
	r1.x = r1.x * g_CameraParam.y + g_CameraParam.x;
	r1.x = r1.x + -i.texcoord8.w;
	r1.x = -r1.x + g_WtrFogParam.w;
	r1.yz = -g_WtrFogParam.zx + g_WtrFogParam.wy;
	r1.y = 1 / r1.y;
	r1.z = 1 / r1.z;
	r1.x = r1.y * r1.x;
	r0 = r0 * r1.x;
	r1.x = g_WtrFogParam.y + i.texcoord1.z;
	r1.x = r1.z * r1.x;
	r0 = r1.x * r0 + g_WtrFogColor;
	r1 = r0.w + -0.01;
	clip(r1);
	r0.xyz = r0.xyz * ambient_rate.xyz;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}
