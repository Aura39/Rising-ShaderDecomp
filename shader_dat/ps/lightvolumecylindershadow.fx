sampler g_AlbedoSampler;
float4 g_CameraParam;
float4 g_CylinderPos0;
float4 g_CylinderPos1;
float4 g_LightCol;
sampler g_NormalSampler;
float4x4 g_Proj;
sampler g_ShadowSampler;
sampler g_SpecMaskSampler;
sampler g_SpecPowSampler;
float4 g_TargetUvParam;
sampler g_ZSampler;

float4 main(float4 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float r4;
	float4 r5;
	r0.xyz = g_CylinderPos0.xyz;
	r0.xyz = -r0.xyz + g_CylinderPos1.xyz;
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / r0.w;
	r1.x = 1 / transpose(g_Proj)[0].x;
	r1.y = 1 / texcoord.w;
	r1.yz = r1.yy * texcoord.xy;
	r2.xy = float2(0.5, -0.5);
	r1.yz = r1.yz * r2.xy + g_TargetUvParam.xy;
	r1.yz = r1.yz + 0.5;
	r1.w = r1.y * 2 + -1;
	r2 = tex2D(g_ZSampler, r1.yzzw);
	r2.x = r2.x * g_CameraParam.y + g_CameraParam.x;
	r1.w = r1.w * r2.x;
	r3.x = r1.x * r1.w;
	r1.x = r1.z * -2 + 1;
	r1.x = r2.x * r1.x;
	r3.z = -r2.x;
	r1.w = 1 / transpose(g_Proj)[1].y;
	r3.y = r1.w * r1.x;
	r2.xyz = r3.xyz + -g_CylinderPos0.xyz;
	r1.x = dot(r2.xyz, r0.xyz);
	r0.w = r0.w * r1.x;
	r0.xyz = r0.xyz * r0.www + g_CylinderPos0.xyz;
	r0.xyz = -r3.xyz + r0.xyz;
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	r0.xyz = r0.www * r0.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + g_CylinderPos0.w;
	r1.x = dot(-r3.xyz, -r3.xyz);
	r1.x = 1 / sqrt(r1.x);
	r2.xyz = -r3.xyz * r1.xxx + r0.xyz;
	r3.xyz = normalize(r2.xyz);
	r2 = tex2D(g_NormalSampler, r1.yzzw);
	r2.xyz = r2.xyz * 2 + -1;
	r1.x = dot(r3.xyz, r2.xyz);
	r0.x = dot(r0.xyz, r2.xyz);
	r0.y = max(r1.x, 0);
	r0.z = -r0.y + 1;
	r3 = tex2D(g_SpecMaskSampler, r1.yzzw);
	r1.xw = r3.wz * float2(100, 4);
	r2.x = r0.z * -r1.x + r0.y;
	r0.z = r2.w + -0.495;
	r2.z = (-r0.z >= 0) ? 0 : 1;
	r0.z = (r0.z >= 0) ? -0 : -1;
	r0.z = r0.z + r2.z;
	r2.z = max(r0.z, 0);
	r0.z = r2.z * -0.5 + r2.w;
	r3.xzw = r2.zzz * g_LightCol.xyz;
	r2.z = r0.z + -0.245;
	r2.w = (-r2.z >= 0) ? 0 : 1;
	r2.z = (r2.z >= 0) ? -0 : -1;
	r2.z = r2.z + r2.w;
	r4.x = max(r2.z, 0);
	r0.z = r4.x * -0.25 + r0.z;
	r2.y = r0.z * 4;
	r2 = tex2D(g_SpecPowSampler, r2);
	r2.w = pow(r0.y, r1.x);
	r0.z = (-r0.x >= 0) ? 0 : 1;
	r0.y = (-r0.y >= 0) ? 0 : r0.z;
	r0.z = r0.x * r0.z;
	r0.y = r2.w * r0.y;
	r2.xyz = r0.zzz * -r0.yyy + r2.xyz;
	r0.y = r0.y * r0.z;
	r2.xyz = r3.yyy * r2.xyz + r0.yyy;
	r2.xyz = r2.xyz * r3.xzw;
	r3.xyz = r0.xxx * r3.xzw;
	r0.x = r0.x + -0.5;
	r1.x = max(r0.x, 0);
	r0.xyz = r1.www * r2.xyz;
	r1.w = 1 / g_LightCol.w;
	r0.w = r0.w * r1.w;
	r0.xyz = r0.www * r0.xyz;
	r2.xyz = r0.www * r3.xyz;
	r3 = tex2D(g_AlbedoSampler, r1.yzzw);
	r5 = tex2D(g_ShadowSampler, r1.yzzw);
	r0.w = -r5.z + 1;
	r1.yzw = r4.xxx + r3.xyz;
	r0.xyz = r0.xyz * r1.yzw;
	r0.xyz = r3.xyz * r2.xyz + r0.xyz;
	r1.x = r1.x + r3.w;
	r1.xyz = r0.xyz * r1.xxx;
	r1.w = 1;
	o = r0.w * r1;

	return o;
}