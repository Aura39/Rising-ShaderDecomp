float4 g_CameraParam : register(c193);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
sampler g_Sampler2 : register(s2);
sampler g_Sampler3 : register(s3);
float4 g_SoftPTParameter : register(c186);
float4 g_TargetUvParam : register(c194);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = 1 / i.texcoord2.w;
	r0.xy = r0.xx * i.texcoord2.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r1 = tex2D(g_Sampler0, i.texcoord);
	r0.zw = r1.xy + g_Rate.zw;
	r0.xy = r0.zw * g_Rate.xy + r0.xy;
	r0 = tex2D(g_Sampler1, r0);
	r1.xy = g_TargetUvParam.xy + i.texcoord3.xy;
	r1 = tex2D(g_Sampler3, r1);
	r1.x = r1.x * g_CameraParam.y + g_CameraParam.x;
	r1.x = r1.x + -i.texcoord3.w;
	r1.x = r1.x * g_SoftPTParameter.x;
	r2 = tex2D(g_Sampler2, i.texcoord1);
	r0.w = r1.x * r2.w;
	o = r0 * i.texcoord7;

	return o;
}
