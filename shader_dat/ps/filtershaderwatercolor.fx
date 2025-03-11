sampler g_SceneSampler : register(s0);
float4 g_TargetUvParam : register(c194);
float3 g_offset1 : register(c184);
float3 g_offset2 : register(c185);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float r4;
	float4 r5;
	float4 r6;
	r0.xy = g_TargetUvParam.xy + texcoord.xy;
	r1.xy = g_TargetUvParam.xy;
	r0.zw = r1.xy * -g_offset1.xy + r0.xy;
	r2 = tex2D(g_SceneSampler, r0.zwzw);
	r0.z = dot(r2.xyz, 0.298912);
	r1.zw = r1.xy * -g_offset2.xy + r0.xy;
	r3 = tex2D(g_SceneSampler, r1.zwzw);
	r0.w = dot(r3.xyz, 0.298912);
	r1.z = -r0.w + r0.z;
	r1.z = (r1.z >= 0) ? -1 : -0;
	r1.z = r1.z + g_offset1.z;
	r4.x = lerp(r0.z, r0.w, abs(r1.z));
	r5 = lerp(r2, r3, abs(r1.z));
	r0.zw = r1.xy * g_offset2.xy + r0.xy;
	r0.xy = r1.xy * g_offset1.xy + r0.xy;
	r1 = tex2D(g_SceneSampler, r0);
	r0 = tex2D(g_SceneSampler, r0.zwzw);
	r2.x = dot(r0.xyz, 0.298912);
	r2.y = dot(r1.xyz, 0.298912);
	r2.z = -r2.y + r2.x;
	r2.z = (r2.z >= 0) ? -1 : -0;
	r2.z = r2.z + g_offset1.z;
	r3.x = lerp(r2.x, r2.y, abs(r2.z));
	r6 = lerp(r0, r1, abs(r2.z));
	r0.x = -r3.x + r4.x;
	r0.x = (r0.x >= 0) ? -1 : -0;
	r0.x = r0.x + g_offset1.z;
	r1 = lerp(r5, r6, abs(r0.x));
	o.xyz = r1.xyz * g_offset2.zzz;
	o.w = r1.w;

	return o;
}
