sampler Color_1_sampler : register(s0);
float SoftPt_Rate : register(c42);
float4 ambient_rate : register(c40);
float3 fog : register(c50);
float4 fogParam : register(c51);
float4 g_CameraParam : register(c193);
float4 g_TargetUvParam : register(c194);
sampler g_Z_sampler : register(s13);
float4 prefogcolor_enhance : register(c55);

struct PS_IN
{
	float4 color : COLOR;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
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
	r0.x = r0.x + -i.texcoord8.z;
	r0.y = 1 / SoftPt_Rate.x;
	r0.x = r0.y * r0.x;
	r1 = tex2D(Color_1_sampler, i.texcoord);
	r1 = r1 * ambient_rate;
	r2 = r1.w * r0.x + -0.01;
	r1.w = r0.x * r1.w;
	r0 = r1 * i.color;
	clip(r2);
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	r0.w = -fogParam.x + fogParam.y;
	r0.w = 1 / r0.w;
	r1.x = fogParam.y + i.texcoord1.z;
	r0.w = r0.w * r1.x;
	o.xyz = r0.www * r0.xyz + fog.xyz;

	return o;
}
