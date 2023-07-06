float4 g_CameraParam;
float4 g_Rate;
float4 g_Rate2;
sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;
float4 g_TargetUvParam;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = 1 / i.texcoord2.w;
	r0.xy = r0.xx * i.texcoord2.xy;
	r0.y = r0.y * 0.5 + 0.5;
	r1.x = 0.5;
	r0.x = r0.x * r1.x + g_TargetUvParam.x;
	r0.z = -r0.y + g_TargetUvParam.y;
	r0.xy = r0.xz + float2(0.5, 1);
	r0 = tex2D(g_Sampler1, r0);
	r0.x = r0.x * g_CameraParam.y + g_CameraParam.x;
	r0.x = r0.x + -i.texcoord2.w;
	r0.x = r0.x * g_Rate2.x;
	r1 = tex2D(g_Sampler2, i.texcoord);
	r2 = tex2D(g_Sampler0, i.texcoord);
	r0.y = r1.w * r2.w;
	r1.xyz = r2.xyz * g_Rate.yyy + g_Rate.xxx;
	r1.w = r0.x * r0.y;
	o = r1 * i.texcoord1;

	return o;
}
