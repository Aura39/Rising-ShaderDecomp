float4 fog;
float4 fognearfar;
float4 g_CameraParam;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;
float4 g_TargetUvParam;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0.x = fognearfar.y + -i.texcoord1.w;
	r0.x = r0.x * fognearfar.z;
	r0.yzw = 1;
	r1 = tex2D(g_Sampler0, i.texcoord);
	r1 = r1 * g_MatrialColor;
	r0.yzw = r1.xyz * r0.yzw + -fog.xyz;
	o.xyz = r0.xxx * r0.yzw + fog.xyz;
	r0.x = 1 / i.texcoord1.w;
	r0.xy = r0.xx * i.texcoord1.xy;
	r0.y = r0.y * 0.5 + 0.5;
	r1.x = 0.5;
	r0.x = r0.x * r1.x + g_TargetUvParam.x;
	r0.z = -r0.y + g_TargetUvParam.y;
	r0.xy = r0.xz + float2(0.5, 1);
	r0 = tex2D(g_Sampler1, r0);
	r0.x = r0.x * g_CameraParam.y + g_CameraParam.x;
	r0.x = r0.x + -i.texcoord1.w;
	r0.x = r0.x * g_Rate.x;
	r0.x = r0.x * r1.w;
	o.w = r0.x;

	return o;
}
