sampler Color_1_sampler : register(s0);
float4 SoftPt_Rate : register(c44);
float4 ambient_rate : register(c40);
float3 fog : register(c67);
float4 g_CameraParam : register(c193);
float4 g_TargetUvParam : register(c194);
sampler g_Z_sampler : register(s13);
float4 prefogcolor_enhance : register(c77);

struct PS_IN
{
	float4 color : COLOR;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
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
	r0.w = (-SoftPt_Rate.x >= 0) ? -r0.w : -r0.z;
	r0.w = r0.w + r1.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r0.x = (r0.w >= 0) ? r0.x : r0.y;
	r1 = tex2D(Color_1_sampler, i.texcoord);
	r0.y = r1.w * ambient_rate.w;
	r2 = r0.y * r0.x + -0.01;
	r3.w = r0.x * r0.y;
	clip(r2);
	r0.xy = -r1.yy + r1.xz;
	r1.w = max(abs(r0.x), abs(r0.y));
	r0.x = r1.w + -0.015625;
	r0.y = (-r0.x >= 0) ? 0 : 1;
	r0.x = (r0.x >= 0) ? -0 : -1;
	r0.x = r0.x + r0.y;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r1.xz = (r0.xx >= 0) ? r1.yy : r1.xz;
	r3.xyz = r1.xyz * ambient_rate.xyz;
	r1 = -1 + i.color;
	r0 = SoftPt_Rate.y * r1 + r0.z;
	r0 = r0 * r3;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}
